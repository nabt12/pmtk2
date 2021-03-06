%% Illustrate the Robustness of the T-Distribution Compared to the Gaussian.
%#testPMTK
function gaussVsToutlierDemo

warning('off','stats:tlsfit:IterOrEvalLimit');
n = 30;
setSeed(8);
data = randn(n,1);
outliers = [8 ; 8.75 ; 9.5];
nn = length(outliers);
nbins = 7;

figure;
plotHist(data,nbins,n);
plotPDFs(data);
printPmtkFigure('gaussVsT');
figure;
plotHist(data,nbins,n+nn);
plotHist(outliers,nn,n+nn);
plotPDFs([data ; outliers]);
printPmtkFigure('gaussVsToutlier'); 
warning('on','stats:tlsfit:IterOrEvalLimit');
end


% Bucket the data into nbins, divide the size of each bin by norm and plot
% the normalized histogram. 
function plotHist(data,nbins,norm)
    hold on;
    [counts, locations] = hist(data,nbins);
    sCounts = counts ./ norm;
    bar(locations,sCounts);
end
%
function plotPDFs(data)
  pgauss = fit(GaussDist, '-data', DataTable(data));
  pstudent = fit(StudentDist, '-data', DataTable(data));
  xrange = [-5 10];
  h(1) = plotPdf(pgauss, '-xrange', xrange, '-plotArgs', {'b:', 'linewidth', 3});
  hold on
  h(2) = plotPdf(pstudent, '-xrange', xrange, '-plotArgs', {'r-', 'linewidth', 2});
  legend(h, 'gaussian', 'student T')
end



