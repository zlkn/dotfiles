# Python — syntax sampler
from __future__ import annotations
import re
from dataclasses import dataclass
from enum import Enum
from typing import Generic, TypeVar

# TODO(yourname): tighten exception handling
T = TypeVar("T")


class Color(Enum):
    RED = 1
    GREEN = 2
    BLUE = 3


@dataclass(slots=True, frozen=True)
class Point(Generic[T]):
    x: T
    y: T


def memoize(fn):
    cache = {}

    def wrapper(*args, **kwargs):
        key = args, tuple(sorted(kwargs.items()))
        if key in cache:
            return cache[key]
        cache[key] = fn(*args, **kwargs)
        return cache[key]

    return wrapper


@memoize
def distance(a: Point[float], b: Point[float]) -> float:
    dx, dy = a.x - b.x, a.y - b.y
    return (dx**2 + dy**2) ** 0.5


async def fetch(url: str) -> bytes:
    import aiohttp

    async with aiohttp.ClientSession() as s:
        async with s.get(url) as r:
            return await r.read()


pattern = re.compile(r"^hello[\s\-]*(world)?$", re.IGNORECASE | re.M)
names = ["alice", "bob", "éva"]
squares = {n: i * i for i, n in enumerate(names)}

try:
    msg = f"{Color.RED.name} → {distance(Point(0.0, 1.0), Point(2.0, 3.0)):.2f}"
    assert pattern.search("Hello  - world")
except (AssertionError, ValueError) as e:
    print(f"error: {e!r}")
else:
    with open("out.txt", "w", encoding="utf-8") as f:
        f.write(msg + "\n")
finally:
    print(*(x for x in range(3)), end="!\n")
