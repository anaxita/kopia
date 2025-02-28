package winservice

import (
	"context"
	"fmt"
	"log/slog"

	"golang.org/x/sys/windows/svc"
)

type Service struct {
	fn func(ctx context.Context)
}

func NewService(fn func(ctx context.Context)) *Service {
	return &Service{
		fn: fn,
	}
}

func (m *Service) Execute(args []string, r <-chan svc.ChangeRequest, status chan<- svc.Status) (bool, uint32) {
	const cmdsAccepted = svc.AcceptStop | svc.AcceptShutdown | svc.AcceptPauseAndContinue

	status <- svc.Status{State: svc.StartPending}
	status <- svc.Status{State: svc.Running, Accepts: cmdsAccepted}

	ctx, cancel := context.WithCancel(context.Background())
	defer cancel()

	go func() {
		for {
			select {
			case c := <-r:
				switch c.Cmd {
				case svc.Interrogate:
					status <- c.CurrentStatus
				case svc.Stop, svc.Shutdown:
					cancel()
					return
				case svc.Pause:
					status <- svc.Status{State: svc.Paused, Accepts: cmdsAccepted}
				case svc.Continue:
					status <- svc.Status{State: svc.Running, Accepts: cmdsAccepted}
				default:
					slog.Error(fmt.Sprintf("Unexpected service control request #%d", c))
				}
			}
		}
	}()

	m.fn(ctx)

	status <- svc.Status{State: svc.StopPending}
	status <- svc.Status{State: svc.Stopped}
	return false, 1
}
