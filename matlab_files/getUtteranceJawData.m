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

    % plot the jaw signal data
    if show
        plot(jaw_data);
        title('JAW Signal Data');
        xlabel('Time (Samples)');
        ylabel('Amplitude');
    end
end

% getUtteranceJawData('T19_T245_FSed_15_NH_A_13.mat');


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
