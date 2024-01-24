from dataclasses import dataclass

from numpy.typing import NDArray


@dataclass
class Function:
    name: str
    values: NDArray
    sample_rate: float  # Hertz

    def downsampled(self, rate: int):
        return Function(
            name=self.name,
            values=self.values[::rate],
            sample_rate=self.sample_rate / rate,
        )
    
    def __add__(self, func2):
        return Function(
            name=self.name + '+' + func2.name,
            values=self.values + func2.values,
            sample_rate=self.sample_rate,
        )

    def __sub__(self, func2):
        return Function(
            name=self.name + '-' + func2.name,
            values=self.values - func2.values,
            sample_rate=self.sample_rate,
        )

    @property
    def time_step(self) -> float:
        return 1 / self.sample_rate
