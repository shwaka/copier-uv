import pytest

from src.{{project_name_snake_case}}.add import add

@pytest.mark.parametrize(
    "a, b, expected", [
        (1, 2, 3),
        (4, 5, 9),
        (-1, 3, 2),
    ]
)
def test_add(a: int, b: int, expected: int) -> None:
    assert add(a, b) == expected
