function path = GiveFirstFolers(FullPath,FoldersToEgnore)

PathParts = strsplit(FullPath,filesep);
L = length(PathParts);
n = L - FoldersToEgnore ;
path = [];
for i = 1:n
    path = [path,PathParts{i},filesep];
end
end