function PlotEnergyFunction(E_plot_pos,E_plot_neg)

    figure, plot(E_plot_pos,'k','linewidth',2)
    grid,hold on
    plot(E_plot_neg,'b','linewidth',2)

    xlabel('No. of epochs','fontsize',14,'fontweight','b')
    ylabel('Energy','fontsize',14,'fontweight','b')
    set(gca,'fontsize',12,'fontweight','b')
    [E_end,I] = max([E_plot_pos(end),E_plot_neg(end)]);
    E_start = [E_plot_pos(1),E_plot_neg(1)];
    str = sprintf('Energy start: %0.6f      Energy end: %0.6f', E_start(I), E_end);
    title(str);
    legend('winit','-winit','location','southeast')
    
end

