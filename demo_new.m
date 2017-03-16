%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LabelMe
%
% This script contains a number of examples about how to use the most
% important functions of this toolbox.
%
% You need to download all the images and annotations first.
% http://people.csail.mit.edu/brussell/research/LabelMe/intro.html
% github link : https://github.com/CSAILVision/LabelMeToolbox
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all
close all

% Define the root folder for the images
dir = '/Users/SK/Desktop/cmu/apc/data/apc_0315/raw/collection_all/';
HOMEIMAGES = [dir 'Images']; % you can set here your default folder
HOMEANNOTATIONS = [dir 'Annotations/users/JudyMRSD/2017_small_set']; % you can set here your default folder

% Define the root folder for the images
NEWHOMEDIR = '/Users/SK/Desktop/cmu/apc/data/apc_0315/';
NEWDATABASENAME = 'APC40';
NEWHOMELMSEGMENTS = [NEWHOMEDIR NEWDATABASENAME '/SegmentationClass'];
NEWIMAGESIZE = [360, 640];

% This line reads the entire database into a Matlab struct
database = LMdatabase(HOMEANNOTATIONS);

load('namelist_old.mat');
objectlist = '';
if size(namelist_old,1) > 1
    objectlist = namelist_old{1,1};
end
for i = 2:size(namelist_old,1)
    objectlist = [objectlist ',' namelist_old{i,1}];
end

objectlist
% Composing queries:
% [D,j] = LMquery(database, 'object.name', 'cloud_b_plush_bear');
% LMdbshowscenes(D, HOMEIMAGES); % this shows only the cloud_b_plush_bear side views
% LMdbshowobjects(D, HOMEIMAGES); % this show tight crops of cloud_b_plush_bear side views.

% VISUALIZATIONS:
% You can visualize the individual objects or their segmentations within
% the large scenes. Compare the next two functions:
% LMdbshowscenes(LMquery(database, 'object.name', objectlist), HOMEIMAGES);
% LMdbshowobjects(LMquery(database, 'object.name', objectlist), HOMEIMAGES);

%LMdbshowscenes(LMquery(database, 'object.name', objectlist)); % shows all the images that have at least one deleted polygon
%LMdbshowobjects(LMquery(database, 'object.name', 'windex'),HOMEIMAGES); % shows all the images that have at least one deleted polygon


[D,j] = LMquery(database, 'object.name', objectlist);

[img, seg, names] = LM2segments(D, NEWIMAGESIZE, HOMEIMAGES, NEWHOMELMSEGMENTS, objectlist);

TraindataPercentage = .8; % percentage images used for training
labelme2pascal(D, NEWDATABASENAME, HOMEIMAGES, NEWHOMEDIR, TraindataPercentage, NEWIMAGESIZE);

