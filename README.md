# TABPLOT.m
Easily plot axes into [uitabs](https://www.mathworks.com/help/matlab/ref/uitab.html) instead of using subplots or multiple figures. If you're struggling with multiple figures or large subplots then TABPLOT is for you!

TABPLOT requires MATLAB 2014b or newer.

## Getting Started
TABPLOT works much like SUBPLOT; in this example TABPLOT is used to create a new figure and returns an array of axes handles, one for each tab created.
```matlab
ax = tabplot(2);
t = linspace(-pi, pi, 128);
plot(ax(1), sin(t), 'LineWidth', 2, 'Color', 'blue');
plot(ax(2), cos(t), 'LineWidth', 2, 'Color', 'red');
```

More advanced functions are available such as specifying the tab tiles and position in the tab group.
```matlab
ax = tabplot(2, 'Title', {'Sine', 'Cosine'}, 'TabLocation', 'Bottom');
t = linspace(-pi, pi, 128);
plot(ax(1), sin(t), 'LineWidth', 2, 'Color', 'blue');
plot(ax(2), cos(t), 'LineWidth', 2, 'Color', 'red');
```

Finally, because TABPLOT returns arrays of axes and [uitab](https://www.mathworks.com/help/matlab/ref/uitab.html) handles you can easily set properties in batch.
```matlab
[ax, tabs, group] = tabplot(3, 'Title', {'Sine', 'Cosine', 'Tangent'});
t = linspace(-pi, pi, 128);
plot(ax(1), t, sin(t), 'LineWidth', 2, 'Color', 'red');
plot(ax(2), t, cos(t), 'LineWidth', 2, 'Color', 'blue');
plot(ax(3), t, tan(t), 'LineWidth', 2, 'Color', 'green');
set(ax, 'XLim', [-pi, pi]);
set(tabs, 'BackgroundColor', 'white');
```
