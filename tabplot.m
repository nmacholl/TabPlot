function [a, t, g] = tabplot(numTabs, varargin)
%TABPLOT Creates tab seperated axes in the current figure.
%   A = TABPLOT(m), creates m tabs in a new Figure window each containing
%   one axes and returns an array of axes handles.
%
%   TABPLOT(m), creates m tabs in the current figure, or a new figure, and
%   places an axes in each tab.
%   TABPLOT(m, 'Titles', C), creates m tabs in the current figure, or a new
%   figure, and places an axes in each tab. If C is a 1xm cell array of
%   chars, the tabs will use the values of C as their titles.
%   TABPLOT(m, 'TabLocation', s), creates m tabs in the current figure, or
%   a new figure, and places an axes in each tab. The tabs will be
%   positioned in the tabgroup location named by s; such as top, left,
%   bottom, or right.
    
    ip = inputParser;
    addRequired(ip, 'numTabs', @isnumeric);
    addOptional(ip, 'Title', {}, @iscell);
    addOptional(ip, 'TabLocation', 'top', @ischar);
    addOptional(ip, 'CreateAxes', 'on', @ischar);
    parse(ip, numTabs, varargin{:});
    assert(numTabs>0 && rem(numTabs,1) == 0, 'Number of tabs must be a positive integer.');
    if ~isempty(ip.Results.Title)
        assert(all(cellfun(@ischar, ip.Results.Title)), 'Titles must be character arrays.');
    end
    assert(any(strcmpi(ip.Results.TabLocation, {'top', 'bottom', 'left', 'right'})), sprintf('Tab location ''%s'' is not a valid location.', ip.Results.TabLocation));
    assert(any(strcmpi(ip.Results.CreateAxes, {'on', 'off'})), sprintf('CreateAxes can be set to either on or off.'));
    if isempty(gcf)
        fig = figure(); 
    else
        fig = gcf;
        delete(get(fig, 'Children'));
    end
    g = uitabgroup('Parent', fig,...
                   'Units', 'normalized',...
                   'Position', [0.01 0.01 0.98 0.98],...
                   'TabLocation', ip.Results.TabLocation);         
    a = zeros(1, numTabs);
    t = zeros(1, numTabs);
    for k = 1:numTabs
        t(k) = uitab('Parent', g,...
                     'Title', sprintf('axes_%d', k));
        if strcmpi(ip.Results.CreateAxes, 'on')
            a(k) = axes('Parent', t(k));
        else
            a(k) = NaN;
        end
        if isfield(ip.Results, 'Title') && k <= numel(ip.Results.Title)
            set(t(k), 'Title', ip.Results.Title{k}); 
        end
    end
    if strcmpi(ip.Results.CreateAxes, 'on')
        axes(a(start));
    else
        a = []; 
    end
end
