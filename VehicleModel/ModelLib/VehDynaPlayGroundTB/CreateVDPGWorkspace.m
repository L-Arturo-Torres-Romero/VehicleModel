
toolboxName = 'Vehicle Dynamics Play Ground';
% Get MATLAB installation folder
addonsPath = matlab.internal.addons.util.retrieveAddOnsInstallationFolder;

toolboxPath = fullfile(addonsPath, 'toolboxes', toolboxName);

% Get the default user folder
userFolder = fullfile(getenv('USERPROFILE'), 'Documents', 'MATLAB');

% Destination folder for the toolbox
destFolder = fullfile(userFolder, toolboxName);

% Check if toolbox exists
if ~isfolder(toolboxPath)
    error('Toolbox folder does not exist: %s', toolboxPath);
end

% Copy files and folders
folder2copy = fullfile(toolboxPath, 'VehicleModel');
copyfile(folder2copy, destFolder, 'f');

% Delete unnecesary folders
folder2delete = fullfile(destFolder, 'ModelLib','VehDynaPlayGroundTB');
rmdir(folder2delete, 's'); 


fprintf('Workspace "%s" copied successfully to: %s\n', toolboxName, destFolder);
