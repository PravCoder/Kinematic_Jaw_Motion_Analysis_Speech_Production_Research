% gets the jaw_data 6 columns from utterance's .mat file
function [output] = getUtteranceJawData(matFileName, show)
    % getUtteranceJawData: Loads utterance data from a .mat file, finds the JAW data, and plots it.
    % input: matFileName - Name of the .mat file containing the utterance data.        

    % load in utterance data file
    data = load(matFileName);

    % get the struct-data associated with cur-utterance
    utterance_struct = data.(matFileName(1:end-4)); % dynamic field name based on file

    % displays struct shape & fields of utterance-struct
    disp("*UTTERANCE STRUCTURE INFO*")
    disp(utterance_struct);

    % stores index of 'JAW' in struct's NAME field
    jaw_index = 0;

    % iterate values of NAME field in struct
    disp("*ITERATE DISPLAY ALL VALUES OF A FIELD IN UTTERANCE STRUCT*")
    for i = 1:length(utterance_struct) % iterate over struct rows
        disp(utterance_struct(i).NAME); % eisplay NAME field
        % if the current value in the NAME field is JAW, we found the JAW element
        if strcmp(utterance_struct(i).NAME, 'JAW')
            jaw_index = i;  
        end
    end

    % extract jaw data using the index found in the NAME field
    jaw_data = utterance_struct(jaw_index).SIGNAL;
    disp(jaw_data);  % display the jaw signal data
    disp("Above is jaw_data from get utterance");
    output = jaw_data;

    % PLOT THE SIX COLUMNS OF JAW DATA FOR AN UTTERANCE 
    if show
        sampling_rate = 250;  % 250 samples per second
        num_rows = size(jaw_data, 1); % get number of rows for the 6-col .mat jaw data for the utterance
        time_column = zeros(num_rows, 1);  % init a vector for time-col, each row corresponding a time step, length of number of rows
        
        % iterate the indicies of rows
        for i = 1:num_rows
            % compute msec time value of each timestep using sampling rate
            % and convert to msc multiply 1000
            time_column(i) = (i-1) / sampling_rate * 1000

        disp("rows below")
        disp(num_rows)
        
  
        % extract all rows for cur-col-indx, choose which col to plot in
        % .mat data.
        plot(time_column, jaw_data(:, 1), 'DisplayName', ['Column ' num2str(1)]);
        
        % Add labels, title, and legend
        xlabel('Time (ms)');
        ylabel('Amplitude');
        title('Jaw Movement Trajectories');
        legend('show'); % Display the legend for the columns
        grid on; % Optional: Add a grid
        hold off; % End plotting
        
        
        disp("time col below")
        disp(time_column)

    end
end

% getUtteranceJawData('T19_T245_FSed_15_NH_A_13.mat', false);
% getUtteranceJawData('T19_T3_SUet_1_NH_A_12.mat', true);

%{
COMMENTS

**utterance_struct**
1×6 struct array with fields:

    NAME
    SRATE
    SIGNAL
    SOURCE

dont try to run this file because it uses its parameters inside the func and we cannot call this function under the primary func 
have to call this function in cmd-line with getUtteranceJawData('T19_T245_FSed_15_NH_A_13.mat', false);
this is a primary function
%}
