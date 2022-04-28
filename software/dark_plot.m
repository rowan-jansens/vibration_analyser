function res =  dark_plot()
    lgd.Color = [0 0 0];
    lgd.TextColor = [1 1 1];
    lgd.EdgeColor = [0.4 0.4 0.4];
set(gca,'Color',[0.1 0.1 0.1])
set(gca,'GridColor',[1 1 1])
set(gca,'ThetaColor',[ 1 1 1])
set(gca,'RColor',[1 1 1])
set(gcf, 'InvertHardCopy', 'off'); 
set(gcf, 'Color', [0 0 0]); 
end