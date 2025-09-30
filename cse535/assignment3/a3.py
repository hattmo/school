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

        cpu_sum = np.sum(self.df['CPU_Usage_Percent']) 
        mem_sum = np.sum(self.df['Memory_Usage_MB'])
        net_sum = np.sum(self.df['Network_Activity_KB'])
        disk_sum = np.sum(self.df['Disk_IO_MB'])

        cpu = weights[0] * cpu_sum
        mem = weights[1] * mem_sum
        net = weights[2] * net_sum
        disk = weights[3] * disk_sum

        total = cpu + mem + net + disk

        sensitivities = [
            round(cpu / total * 100, 2),
            round(mem / total * 100, 2),
            round(net / total * 100, 2),
            round(disk / total * 100, 2)
        ]
        return tuple(np.float64(x) for x in sensitivities)

    def generate_power_statistics(self, weights):
        if self.df is None:
            raise Exception()
        weighted_sum = (
            self.df['CPU_Usage_Percent'] * weights[0] +
            self.df['Memory_Usage_MB'] * weights[1] +
            self.df['Network_Activity_KB'] * weights[2] +
            self.df['Disk_IO_MB'] * weights[3]
        )
        power = weighted_sum / self.df['Execution_Time_s']
        power = np.round(power, 2)
        avg = np.round(np.mean(power), 2)
        max_app = self.df['Application'][np.argmax(power)]
        min_app = self.df['Application'][np.argmin(power)]
        return (avg, max_app, min_app)

    def calculate_power_sensitivites(self, weights):
        if self.df is None:
            raise Exception()
        cpu = np.sum(self.df['CPU_Usage_Percent'] * weights[0] / self.df['Execution_Time_s'])
        mem = np.sum(self.df['Memory_Usage_MB'] * weights[1] / self.df['Execution_Time_s'])
        net = np.sum(self.df['Network_Activity_KB'] * weights[2] / self.df['Execution_Time_s'])
        disk = np.sum(self.df['Disk_IO_MB'] * weights[3] / self.df['Execution_Time_s'])
        total = cpu + mem + net + disk
        sensitivities = [
            np.round(cpu / total * 100, 2),
            np.round(mem / total * 100, 2),
            np.round(net / total * 100, 2),
            np.round(disk / total * 100, 2)
        ]
        return tuple(np.float64(x) for x in sensitivities)
