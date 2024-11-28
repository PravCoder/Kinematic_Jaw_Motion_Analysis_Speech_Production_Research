
function Extract_Jaw_Interval(mat_file_path, lab_file_path)
    jaw_data = getUtteranceJawData(mat_file_path, false);

    % load corresponding utterance tsv file as a table, each column is
    % given a ambigous name like Var1, Var2, ...
    tsv_data = readtable(lab_file_path, 'FileType', 'text', 'Delimiter', '\t');
    disp(tsv_data)
    disp("Above is tsv data for utterance")
    
    % extract endpoints of interval from utterance-tsv file
    var3_column = tsv_data.Var3; % get 3rd col
    first_num = var3_column(1, :); % get the first row of 3-col, which is just a single num
    last_num = var3_column(6, :);  % get the sixth row of 3-col
    disp(first_num);
    disp(last_num);
    disp("Above the endpoints of interval");
       
    % for now testing purposes hard code the endpoints & time-col, until we
    % figure out the 
    first_num = 2.807010122745389;
    last_num = 2.822477731747881; 
    time_col_indx = 3; % define index of time-column
    
    % disp(jaw_data(:, time_col_indx));
    
    % stores rows of all 6-cols of interval between first-num to last-num
    % of an utterance, matrix
    utterance_interval = [];
    found_bound = false; 
    % iterate every row of jaw_data, i=row-indx
    for i = 1:size(jaw_data, 1) 

        %disp(jaw_data(i, :));
        % if the cur-row-time-col-cell is the first-bound start collecting
        % those rows because they are in the interval
        cur_time_cell = abs(jaw_data(i, time_col_indx));
        if cur_time_cell == first_num || found_bound == true
            %disp(jaw_data(i, :));
            % add cur-row of to matrix
            utterance_interval = [utterance_interval; jaw_data(i, :)]; 
            found_bound = true; % indicate we found the starting-bound
            if cur_time_cell == last_num % if we reached the ending-bound stop collecting rows
                break
            end
        end 
    end
    disp(utterance_interval);
    disp("Above is extracted interval of utterance")
    

end



% call: Extract_Jaw_Interval('T19_T245_FSed_15_NH_A_13.mat', 'T19_T245_FSed_15_NH_A_13.tsv')