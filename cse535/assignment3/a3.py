import pandas as pd
import numpy as np

class A3:
    def __init__(self):
        self.df = None

    def read_dataset(self):
        self.df = pd.read_csv('dataset.csv')

    def generate_energy_statistics(self, weights):
        if self.df is None:
            raise Exception()
        energy = (
            self.df['CPU_Usage_Percent'] * weights[0] +
            self.df['Memory_Usage_MB'] * weights[1] +
            self.df['Network_Activity_KB'] * weights[2] +
            self.df['Disk_IO_MB'] * weights[3]
        )
        avg = np.round(np.mean(energy.astype(np.float64)), 2)
        max = self.df['Application'][np.argmax(energy)]
        min = self.df['Application'][np.argmin(energy)]
        return (avg, max, min)

    def calculate_energy_sensitivites(self, weights):
        if self.df is None:
            raise Exception()

        cpu_sum = np.sum(self.df['CPU_Usage_Percent'] * self.df['Execution_Time_s'])
        mem_sum = np.sum(self.df['Memory_Usage_MB'] * self.df['Execution_Time_s'])
        net_sum = np.sum(self.df['Network_Activity_KB'] * self.df['Execution_Time_s'])
        disk_sum = np.sum(self.df['Disk_IO_MB'] * self.df['Execution_Time_s'])

        cpu = weights[0] * cpu_sum
        mem = weights[1] * mem_sum
        net = weights[2] * net_sum
        disk = weights[3] * disk_sum

        total = cpu + mem + net + disk

        sensitivities = [
            np.round(cpu / total * 100, 2),
            np.round(mem / total * 100, 2),
            np.round(net / total * 100, 2),
            np.round(disk / total * 100, 2)
        ]
        return tuple(sensitivities)

    def generate_power_statistics(self, weights):
        if self.df is None:
            raise Exception()
        energy = (
            self.df['CPU_Usage_Percent'] * weights[0] +
            self.df['Memory_Usage_MB'] * weights[1] +
            self.df['Network_Activity_KB'] * weights[2] +
            self.df['Disk_IO_MB'] * weights[3]
        ) * self.df['Execution_Time_s']

        power = energy / self.df['Exe cutionTimes']
        power = np.round(power, 2)
        avg = np.round(np.mean(power), 2)
        max = self.df['Application'][np.argmax(power)]
        min = self.df['Application'][np.argmin(power)]
        return (avg, max, min)

    def calculate_power_sensitivites(self, weights):
        if self.df is None:
            raise Exception()
        cpu = np.sum(self.df['CPU_Usage_Percent'] * weights[0])
        mem = np.sum(self.df['Memory_Usage_MB'] * weights[1])
        net = np.sum(self.df['Network_Activity_KB'] * weights[2])
        disk = np.sum(self.df['Disk_IO_MB'] * weights[3])

        total = cpu + mem + net + disk

        sensitivities = [
            np.round(cpu / total * 100, 2),
            np.round(mem / total * 100, 2),
            np.round(net / total * 100, 2),
            np.round(disk / total * 100, 2)
        ]
        return tuple(sensitivities)


def main():
    a = A3()
    a.read_dataset()
    a.generate_energy_statistics([1,2,3,4])

if __name__ == '__main__':
    main()
