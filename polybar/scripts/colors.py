def color(color: str, message: str):
    return '%{F' + color + '}' + message + '%{F-}'

def error(message: str):
    return color('#BF616A', message)

def warning(message: str):
    return color('#EBCB8B', message)
