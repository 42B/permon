from abc import ABC, abstractmethod
from collections import OrderedDict
import numpy as np
import permon.backend as backend


class Monitor(ABC):
    def __init__(self, stat_func, title, buffer_size, fps, color, app,
                 minimum=None, maximum=None):
        if minimum and maximum:
            assert np.abs(maximum - minimum) > 0, \
                'Graph range must be greater than zero.'

        self.stat_func = stat_func
        self.title = title
        self.buffer_size = buffer_size
        self.fps = fps
        self.color = color
        self.minimum = minimum
        self.maximum = maximum
        self.app = app

    def remove(self):
        self.app.remove_monitor(self)

    @abstractmethod
    def update(self):
        pass

    @abstractmethod
    def paint(self):
        pass


class MonitorApp(ABC):
    def __init__(self, tags, colors, buffer_size, fps):
        self.tags = tags
        self.colors = colors
        self._color_index = 0
        self.buffer_size = buffer_size
        self.fps = fps
        self.monitors = []

        self.stats = []
        for stat in backend.get_available_stats():
            if stat.get_full_tag() in tags:
                instance = stat()
                self.stats.append(instance)

    def next_color(self):
        color_counts = OrderedDict([(color, 0) for color in self.colors])
        for monitor in self.monitors:
            color_counts[monitor.color] += 1

        min_count = min(color_counts.values())
        for color, count in color_counts.items():
            if count == min_count:
                return color

    @abstractmethod
    def initialize(self):
        pass

    def update(self):
        for monitor in self.monitors:
            monitor.update()

    @abstractmethod
    def paint(self):
        pass
