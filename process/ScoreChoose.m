function y = ScoreChoose(Scores,mod)
switch mod
    case 'mean'
        Score = zeros(size(Scores{1}));
        for j = 1:length(Scores)
            Score = Score + Scores{j} ;
        end
        %% max calculation
        [~,y] = max(Score(:,2)) ;
    case 'wise'
        waste_ratio = 0.1 ;
        s = length(Scores);
        dif = zeros(1,s) ;
        for j = 1:s
            Sorted_scores = sort(Scores{j}(:,2),'descend') ;
            dif(j) = Sorted_scores(1) - Sorted_scores(2) ;
        end
        % waste or not
        max_dif = max(dif);
        indx = ~ (dif<(waste_ratio*max_dif)) ;
        Scores(indx) ;
        % final decision
        y = ScoreChoose(Scores(indx),'mean') ;
    case 'max'

        s = length(Scores);
        dif = zeros(1,s) ;
        for j = 1:s
            Sorted_scores = sort(Scores{j}(:,2),'descend') ;
            dif(j) = Sorted_scores(1) - Sorted_scores(2) ;
        end
        % max
        [~,indx] = max(dif);
        Scores(indx) ;
        % final decision
        y = ScoreChoose(Scores(indx),'mean') ;
end


end