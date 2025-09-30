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
        ) * self.df['ExecutionTimes']

        energy = np.round(energy, 2)
        avg = np.round(np.mean(energy), 2)
        max = self.df['Application'][np.argmax(energy)]
        min = self.df['Application'][np.argmin(energy)]
        return (avg, max, min)

    def calculate_energy_sensitivites(self, weights):
        if self.df is None:
            raise Exception()

        cpu = np.sum(self.df['CPU_Usage_Percent'] * weights[0] * self.df['ExecutionTimes'])
        mem = np.sum(self.df['Memory_Usage_MB'] * weights[1] * self.df['ExecutionTimes'])
        net = np.sum(self.df['Network_Activity_KB'] * weights[2] * self.df['ExecutionTimes'])
        disk = np.sum(self.df['Disk_IO_MB'] * weights[3] * self.df['ExecutionTimes'])

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
        ) * self.df['ExecutionTimes']

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

