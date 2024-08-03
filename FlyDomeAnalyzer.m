classdef FlyDomeAnalyzer < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                        matlab.ui.Figure
        FlyDomeAnalyzerLabel            matlab.ui.control.Label
        SteprequiredonlywensettingupfirsttimeLabel_8  matlab.ui.control.Label
        SteprequiredonlywensettingupfirsttimeLabel_7  matlab.ui.control.Label
        SteprequiredonlywensettingupfirsttimeLabel_6  matlab.ui.control.Label
        SteprequiredonlywensettingupfirsttimeLabel_5  matlab.ui.control.Label
        SteprequiredonlywensettingupfirsttimeLabel_4  matlab.ui.control.Label
        Label                           matlab.ui.control.Label
        SteprequiredonlywensettingupfirsttimeLabel_3  matlab.ui.control.Label
        SteprequiredonlywensettingupfirsttimeLabel_2  matlab.ui.control.Label
        SteprequiredonlywensettingupfirsttimeLabel  matlab.ui.control.Label
        DomeAnalyzerButton              matlab.ui.control.Button
        JAABAPlotButton                 matlab.ui.control.Button
        CreateJAABAPlotInputButton      matlab.ui.control.Button
        SetFixtraxParamsButton          matlab.ui.control.Button
        RunFixtraxButton                matlab.ui.control.Button
        GenerateInputsforFixtraxButton  matlab.ui.control.Button
        SetPathofFlyDomeAnalyzerButton  matlab.ui.control.Button
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: SetPathofFlyDomeAnalyzerButton
        function set_flydomeanalyzer_path(app, event)
            set_flydomeanalyzer_path;
        end

        % Button pushed function: GenerateInputsforFixtraxButton
        function generate_fixtrax_input(app, event)
            generate_fixtrax_input;
        end

        % Button pushed function: RunFixtraxButton
        function Fixtrax(app, event)
            FixTrackingFiles;
        end

        % Button pushed function: SetFixtraxParamsButton
        function Fixtrax_params(app, event)
            ChooseFliesNames;
        end

        % Button pushed function: CreateJAABAPlotInputButton
        function create_JAABAPlot_input(app, event)
            Fixtrax_folder_path_extractor
        end

        % Button pushed function: JAABAPlotButton
        function JAABAPlot(app, event)
            JAABAPlot;
        end

        % Button pushed function: DomeAnalyzerButton
        function DomeAnalyzer(app, event)
            domeanalyzer;
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 546 452];
            app.UIFigure.Name = 'MATLAB App';

            % Create SetPathofFlyDomeAnalyzerButton
            app.SetPathofFlyDomeAnalyzerButton = uibutton(app.UIFigure, 'push');
            app.SetPathofFlyDomeAnalyzerButton.ButtonPushedFcn = createCallbackFcn(app, @set_flydomeanalyzer_path, true);
            app.SetPathofFlyDomeAnalyzerButton.BackgroundColor = [1 1 1];
            app.SetPathofFlyDomeAnalyzerButton.FontSize = 14;
            app.SetPathofFlyDomeAnalyzerButton.FontWeight = 'bold';
            app.SetPathofFlyDomeAnalyzerButton.Position = [7 65 211 25];
            app.SetPathofFlyDomeAnalyzerButton.Text = 'Set Path of FlyDomeAnalyzer';

            % Create GenerateInputsforFixtraxButton
            app.GenerateInputsforFixtraxButton = uibutton(app.UIFigure, 'push');
            app.GenerateInputsforFixtraxButton.ButtonPushedFcn = createCallbackFcn(app, @generate_fixtrax_input, true);
            app.GenerateInputsforFixtraxButton.BackgroundColor = [1 1 1];
            app.GenerateInputsforFixtraxButton.FontSize = 14;
            app.GenerateInputsforFixtraxButton.FontWeight = 'bold';
            app.GenerateInputsforFixtraxButton.Position = [14 350 195 25];
            app.GenerateInputsforFixtraxButton.Text = 'Generate Inputs for Fixtrax';

            % Create RunFixtraxButton
            app.RunFixtraxButton = uibutton(app.UIFigure, 'push');
            app.RunFixtraxButton.ButtonPushedFcn = createCallbackFcn(app, @Fixtrax, true);
            app.RunFixtraxButton.BackgroundColor = [1 1 1];
            app.RunFixtraxButton.FontSize = 14;
            app.RunFixtraxButton.FontWeight = 'bold';
            app.RunFixtraxButton.Position = [56 294 100 25];
            app.RunFixtraxButton.Text = 'Run Fixtrax';

            % Create SetFixtraxParamsButton
            app.SetFixtraxParamsButton = uibutton(app.UIFigure, 'push');
            app.SetFixtraxParamsButton.ButtonPushedFcn = createCallbackFcn(app, @Fixtrax_params, true);
            app.SetFixtraxParamsButton.BackgroundColor = [1 1 1];
            app.SetFixtraxParamsButton.FontSize = 14;
            app.SetFixtraxParamsButton.FontWeight = 'bold';
            app.SetFixtraxParamsButton.Position = [40 22 141 25];
            app.SetFixtraxParamsButton.Text = 'Set Fixtrax Params';

            % Create CreateJAABAPlotInputButton
            app.CreateJAABAPlotInputButton = uibutton(app.UIFigure, 'push');
            app.CreateJAABAPlotInputButton.ButtonPushedFcn = createCallbackFcn(app, @create_JAABAPlot_input, true);
            app.CreateJAABAPlotInputButton.BackgroundColor = [1 1 1];
            app.CreateJAABAPlotInputButton.FontSize = 14;
            app.CreateJAABAPlotInputButton.FontWeight = 'bold';
            app.CreateJAABAPlotInputButton.Position = [21 235 175 25];
            app.CreateJAABAPlotInputButton.Text = 'Create JAABAPlot Input';

            % Create JAABAPlotButton
            app.JAABAPlotButton = uibutton(app.UIFigure, 'push');
            app.JAABAPlotButton.ButtonPushedFcn = createCallbackFcn(app, @JAABAPlot, true);
            app.JAABAPlotButton.BackgroundColor = [1 1 1];
            app.JAABAPlotButton.FontSize = 14;
            app.JAABAPlotButton.FontWeight = 'bold';
            app.JAABAPlotButton.Position = [57 182 100 25];
            app.JAABAPlotButton.Text = 'JAABAPlot';

            % Create DomeAnalyzerButton
            app.DomeAnalyzerButton = uibutton(app.UIFigure, 'push');
            app.DomeAnalyzerButton.ButtonPushedFcn = createCallbackFcn(app, @DomeAnalyzer, true);
            app.DomeAnalyzerButton.BackgroundColor = [1 1 1];
            app.DomeAnalyzerButton.FontSize = 14;
            app.DomeAnalyzerButton.FontWeight = 'bold';
            app.DomeAnalyzerButton.Position = [52 123 116 25];
            app.DomeAnalyzerButton.Text = 'Dome Analyzer';

            % Create SteprequiredonlywensettingupfirsttimeLabel
            app.SteprequiredonlywensettingupfirsttimeLabel = uilabel(app.UIFigure);
            app.SteprequiredonlywensettingupfirsttimeLabel.FontSize = 14;
            app.SteprequiredonlywensettingupfirsttimeLabel.Position = [240 60 294 34];
            app.SteprequiredonlywensettingupfirsttimeLabel.Text = {'Step required only wen setting up first time or '; 'when folder location is changed'};

            % Create SteprequiredonlywensettingupfirsttimeLabel_2
            app.SteprequiredonlywensettingupfirsttimeLabel_2 = uilabel(app.UIFigure);
            app.SteprequiredonlywensettingupfirsttimeLabel_2.FontSize = 14;
            app.SteprequiredonlywensettingupfirsttimeLabel_2.Position = [239 344 284 34];
            app.SteprequiredonlywensettingupfirsttimeLabel_2.Text = {'Select the parent directory containing all the '; 'folders tracked with FlyTracker'};

            % Create SteprequiredonlywensettingupfirsttimeLabel_3
            app.SteprequiredonlywensettingupfirsttimeLabel_3 = uilabel(app.UIFigure);
            app.SteprequiredonlywensettingupfirsttimeLabel_3.FontSize = 14;
            app.SteprequiredonlywensettingupfirsttimeLabel_3.Position = [240 295 231 22];
            app.SteprequiredonlywensettingupfirsttimeLabel_3.Text = 'Run Fixtrax as prompted by the GUI';

            % Create Label
            app.Label = uilabel(app.UIFigure);
            app.Label.Position = [14 100 522 22];
            app.Label.Text = '____________________________________________________________________________';

            % Create SteprequiredonlywensettingupfirsttimeLabel_4
            app.SteprequiredonlywensettingupfirsttimeLabel_4 = uilabel(app.UIFigure);
            app.SteprequiredonlywensettingupfirsttimeLabel_4.FontSize = 14;
            app.SteprequiredonlywensettingupfirsttimeLabel_4.Position = [239 230 284 34];
            app.SteprequiredonlywensettingupfirsttimeLabel_4.Text = {'Select the parent directory containing all the '; 'folders corrected by Fixtrax'};

            % Create SteprequiredonlywensettingupfirsttimeLabel_5
            app.SteprequiredonlywensettingupfirsttimeLabel_5 = uilabel(app.UIFigure);
            app.SteprequiredonlywensettingupfirsttimeLabel_5.FontSize = 14;
            app.SteprequiredonlywensettingupfirsttimeLabel_5.Position = [239 173 287 34];
            app.SteprequiredonlywensettingupfirsttimeLabel_5.Text = {'Classify in batch using the Fixtrax_paths.csv '; 'file created and classifiers of choice'};

            % Create SteprequiredonlywensettingupfirsttimeLabel_6
            app.SteprequiredonlywensettingupfirsttimeLabel_6 = uilabel(app.UIFigure);
            app.SteprequiredonlywensettingupfirsttimeLabel_6.FontSize = 14;
            app.SteprequiredonlywensettingupfirsttimeLabel_6.Position = [239 124 25 22];
            app.SteprequiredonlywensettingupfirsttimeLabel_6.Text = '';

            % Create SteprequiredonlywensettingupfirsttimeLabel_7
            app.SteprequiredonlywensettingupfirsttimeLabel_7 = uilabel(app.UIFigure);
            app.SteprequiredonlywensettingupfirsttimeLabel_7.FontSize = 14;
            app.SteprequiredonlywensettingupfirsttimeLabel_7.Position = [239 112 284 34];
            app.SteprequiredonlywensettingupfirsttimeLabel_7.Text = {'Select the parent directory containing all the '; 'folders classified by JAABA'};

            % Create SteprequiredonlywensettingupfirsttimeLabel_8
            app.SteprequiredonlywensettingupfirsttimeLabel_8 = uilabel(app.UIFigure);
            app.SteprequiredonlywensettingupfirsttimeLabel_8.FontSize = 14;
            app.SteprequiredonlywensettingupfirsttimeLabel_8.Position = [240 17 293 34];
            app.SteprequiredonlywensettingupfirsttimeLabel_8.Text = {'Step required only wen setting up first time to '; 'change video format and other params'};

            % Create FlyDomeAnalyzerLabel
            app.FlyDomeAnalyzerLabel = uilabel(app.UIFigure);
            app.FlyDomeAnalyzerLabel.FontSize = 24;
            app.FlyDomeAnalyzerLabel.FontWeight = 'bold';
            app.FlyDomeAnalyzerLabel.Position = [167 408 207 32];
            app.FlyDomeAnalyzerLabel.Text = 'FlyDomeAnalyzer';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = FlyDomeAnalyzer

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end