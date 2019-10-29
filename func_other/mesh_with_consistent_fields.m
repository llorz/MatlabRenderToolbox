function S = mesh_with_consistent_fields(S)
if ~isstruct(S)
    error('The input should be a mesh with cell structure')
else
    names = fieldnames(S);
    if isfield(S,'T')
        [~,id1] = ismember('T',fieldnames(S));
    else
        id1 = find(~cellfun(@isempty,...
            cellfun(@(x) findstr('TRI',x) == 1,upper(names),'UniformOutput',false))); %#ok<FSTR>
    end
    if isfield(S,'X')
        [~,id2] = ismember('X',fieldnames(S));
    else
        id2 = find(~cellfun(@isempty,...
            cellfun(@(x) findstr('VER',x) == 1,upper(names),'UniformOutput',false))); %#ok<FSTR>
    end
    if ~isfield(S,'surface')
        if isempty(id1) || isempty(id2)
            error('The input should be a mesh!')
        end
    end
    
end 
if isfield(S,'surface') % case 01: mesh has structure S.surface.{X,Y,Z,TRIV}
    if ~isfield(S,'VERT')
        S.VERT = [S.surface.X,S.surface.Y,S.surface.Z];
    end
    if ~isfield(S,'TRIV')
        S.TRIV = S.surface.TRIV;
    end
    if ~isfield(S.surface,'VERT')
        S.surface.VERT = S.VERT;
    end
else % case 02: mesh has structure S.VERT +  S.TRIV
    if ~strcmp(names{id1},'TRIV')
        S.TRIV = getfield(S, names{id1});
    end

    if ~strcmp(names{id2},'VERT')
        S.VERT = getfield(S, names{id2});
    end
    S.surface.X = S.VERT(:,1);
    S.surface.Y = S.VERT(:,2);
    S.surface.Z = S.VERT(:,3);
    S.surface.TRIV = S.TRIV;
    S.surface.VERT = S.VERT;
end

S.nv = length(S.surface.X);
S.n = S.nv;
S.nf = size(S.surface.TRIV,1);
S.m = S.nf;
if ~isfield(S,'name'), S.name = ''; end
end

