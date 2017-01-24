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
HOMEIMAGES = '/Users/SK/Desktop/cmu/apc/data/apc/collection1/Images'; % you can set here your default folder
HOMEANNOTATIONS = '/Users/SK/Desktop/cmu/apc/data/apc/collection1/Annotations/users/JudyMRSD/50_items_5_classes_tighterpolygon'; % you can set here your default folder

% Define the root folder for the images
NEWHOMEDIR = '/Users/SK/Desktop/cmu/apc/data/apc/';
NEWDATABASENAME = 'APC_PASCAL';
NEWHOMELMSEGMENTS = [NEWHOMEDIR NEWDATABASENAME '/SegmentationClass'];

% This line reads the entire database into a Matlab struct
database = LMdatabase(HOMEANNOTATIONS);
objectlist = 'kyjen_squeakin_eggs_plush_puppies,cloud_b_plush_bear,laugh_out_loud_joke_book,creativity_chenille_stems,hanes_tube_socks';

% Composing queries:
% [D,j] = LMquery(database, 'object.name', 'cloud_b_plush_bear');
% LMdbshowscenes(D, HOMEIMAGES); % this shows only the cloud_b_plush_bear side views
% LMdbshowobjects(D, HOMEIMAGES); % this show tight crops of cloud_b_plush_bear side views.

% VISUALIZATIONS:
% You can visualize the individual objects or their segmentations within
% the large scenes. Compare the next two functions:
% LMdbshowscenes(LMquery(database, 'object.name', objectlist), HOMEIMAGES);
% LMdbshowobjects(LMquery(database, 'object.name', objectlist), HOMEIMAGES);


[D,j] = LMquery(database, 'object.name', objectlist);
[img, seg, names] = LM2segments(D, [1080, 1920], HOMEIMAGES, NEWHOMELMSEGMENTS);

TraindataPercentage = .8; % percentage images used for training
labelme2pascal(D, NEWDATABASENAME, HOMEIMAGES, NEWHOMEDIR, TraindataPercentage);

