from tap import Tap
import argcomplete

class FooParser(Tap):
    value: int = 3 # The value printed after "foo"

    @staticmethod
    def _handler(args: "FooParser") -> None:
        print(f"foo {args.value}")

    def configure(self) -> None:
        self.set_defaults(handler=self._handler)

class MainParser(Tap):
    def configure(self) -> None:
        self.add_subparsers(required=True)
        self.add_subparser("foo", FooParser, help="Print foo")

def main() -> None:
    parser = MainParser()
    argcomplete.autocomplete(parser)
    args = parser.parse_args()
    if hasattr(args, "handler"):
        args.handler(args)
    else:
        print("handler is not set")
