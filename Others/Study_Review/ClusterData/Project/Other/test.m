filename = 'olympics-economics.csv';
data = readtable(filename);

% Sort the data by GDP in descending order
sorted_data = sortrows(data, 'gdp', 'descend');

top_gdp = sorted_data.gdp(1:20);
top_gold = sorted_data.gold(1:20);
top_country_codes = sorted_data.country(1:20); % For labels if needed

% Create the scatter plot
scatter(top_gdp, top_gold, 'filled');
xlabel('GDP');
ylabel('Gold Medals');
title('Top 5 GDP Countries vs Gold Medals');
grid on;

% Add annotations to show GDP, gold, and country code
for i = 1:20
    annotation = sprintf('%s: GDP=%.2f, Gold=%d', char(top_country_codes(i)), top_gdp(i), top_gold(i));
    text(top_gdp(i), top_gold(i), annotation, ...
        'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right', ...
        'Rotation', 0); % Rotation can be adjusted
end
