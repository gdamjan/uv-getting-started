import argparse
import importlib.metadata


def main():
    parser = argparse.ArgumentParser(
        prog="ProgramName",
        description="What the program does",
        epilog="Text at the bottom of help",
    )
    parser.add_argument("filename")  # positional argument
    parser.add_argument("-c", "--count")  # option that takes a value
    parser.add_argument("-v", "--verbose", action="store_true")  # on/off flag

    if __package__:
        print(f"Project version is: {importlib.metadata.version(__package__)}")

    args = parser.parse_args()
    print(f"CLI args: {args!r}")


if __name__ == "__main__":
    main()
