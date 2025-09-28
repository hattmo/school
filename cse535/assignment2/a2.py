import numpy as np


class A2:
    def generate_public_key_vector(self, A, s, e, p):
        return ((A @ s) + e) % p

    def encrypt(self, pub_key, vector, plain_text, p):
        A, b = pub_key
        indices = np.where(vector)[0]
        A_sum = np.sum(A[indices, :], axis=0) % p
        b_sum = np.sum(b[indices]) % p
        if plain_text == 1:
            b_sum = (b_sum + (p // 2)) % p
        return (A_sum, b_sum)

    def decrypt(self, priv_key, cipher_text, p):
        s = priv_key
        A_sum, b_sum = cipher_text
        v = np.dot(A_sum, s) % p
        diff = (b_sum - v) % p
        midpoint = p // 2
        if abs(diff - 0) < abs(diff - midpoint):
            return 0
        else:
            return 1


if __name__ == "__main__":
    pass
