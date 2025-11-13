import pdb


class Config(pdb.DefaultConfig):
    pygments_formatter_class = "pygments.formatters.TerminalTrueColorFormatter"
    pygments_formatter_kwargs = {"style": "gruvbox-dark"}
