import numpy as np
from random import random, seed


def index_of_selected(probs: list[float]) -> int:
    r_val = random()
    lower = 0.0
    for i, prob in enumerate(probs):
        upper = lower + prob
        if lower <= r_val < upper:
            return i
        lower = upper
    raise Exception()


class A1:
    def generate_markov_chain(self, potential: list[str], sequence: list[str]):
        self.state_map = {s: i for (i, s) in enumerate(potential)}
        self.states = potential
        num_states = len(potential)
        self.transition_matrix = np.zeros((num_states, num_states))
        seq = iter(sequence)
        on = next(seq)
        for step in seq:
            print(on, step)
            self.transition_matrix[self.state_map[on]][self.state_map[step]] += 1
            on = step
        row_sums = self.transition_matrix.sum(axis=1, keepdims=True)
        nonzero_rows = row_sums[:, 0] != 0
        self.transition_matrix = (
            self.transition_matrix[nonzero_rows] / row_sums[nonzero_rows]
        )
        return self.transition_matrix

    def generate_samples(self, state: str, random_seed: int, length: int) -> list[str]:
        seed(random_seed)
        out = [state]
        on = state
        for _ in range(length):
            n = self.states[
                index_of_selected(self.transition_matrix[self.state_map[on]])
            ]
            out.append(n)
            on = n
        return out

    def stationary_distribution(self):
        eigvals, eigvecs = np.linalg.eig(self.transition_matrix.T)
        stat_idx = np.isclose(eigvals, 1)
        stationary = eigvecs[:, stat_idx].flatten()
        stationary /= stationary.sum()
        return stationary


def test():
    # Define weather states
    states = ["Sunny", "Cloudy", "Rainy"]

    # Sample weather sequence
    weather_sequence = [
        "Sunny",
        "Sunny",
        "Rainy",
        "Cloudy",
        "Sunny",
        "Rainy",
        "Sunny",
        "Sunny",
    ]

    a1 = A1()
    print(a1.generate_markov_chain(states, weather_sequence))
    print(a1.generate_samples("Cloudy", 24, 15))
    print(a1.generate_samples("Cloudy", 10, 5))
    print(a1.stationary_distribution())
    sd = a1.stationary_distribution()
    print(sd @ a1.transition_matrix)
    print(np.isclose(sd @ a1.transition_matrix, sd))


if __name__ == "__main__":
    pass
    test()
