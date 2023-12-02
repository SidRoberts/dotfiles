def truncate(string: str, limit: int):
    if len(string) <= limit:
        return string

    return string[:limit-3] + '...'
