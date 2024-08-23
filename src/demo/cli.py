import argparse


def main():
    parser = argparse.ArgumentParser(
        prog="ProgramName",
        description="What the program does",
        epilog="Text at the bottom of help",
    )
    parser.add_argument("filename")  # positional argument
    parser.add_argument("-c", "--count")  # option that takes a value
    parser.add_argument("-v", "--verbose", action="store_true")  # on/off flag

    args = parser.parse_args()
    print(args.filename, args.count, args.verbose)
