#!/usr/bin/env python
__version__ = '1.0.0'

from permon.frontend import native, terminal
from permon import config


def main():
    from argparse import ArgumentParser

    monitors = config.get_config()['monitors']

    parser = ArgumentParser()
    parser.add_argument('monitors', nargs='*', default=monitors, help=f"""
    which monitors to display.
    If none are given, take those from the config file ({', '.join(monitors)})
    """)
    parser.add_argument('-t', '--terminal', dest='terminal',
                        action='store_true', help=f"""
    use terminal frontend instead of native GUI
    """)
    parser.add_argument('-s', '--store_config', dest='store_config',
                        action='store_true', help=f"""
    store the monitors passed to the monitors argument in the configuration.
    They will be shown per default on the next start of permon.
    """)
    args = parser.parse_args()

    monitors = args.monitors

    if args.store_config:
        config.set_config({
            'monitors': monitors
        })

    # determines which colors are used in frontends that support custom colors
    colors = ['#ed5565', '#ffce54', '#48cfad', '#sd9cec', '#ec87c0',
              '#fc6e51', '#a0d468', '#4fc1e9', '#ac92ec']

    if args.terminal:
        app = terminal.TerminalApp(monitors, colors=colors,
                                   buffer_size=500, fps=10)
    else:
        app = native.NativeApp(monitors, colors=colors,
                               buffer_size=500, fps=10)
    app.initialize()


if __name__ == '__main__':
    main()
