{ config, ... }:
{
  config.programs.yazi.settings.manager = {
    ratio = [ 1 4 4 ];
    sort_by = "natural";
    sort_translit = true;
    sort_dir_first = true;
    linemode = "size_and_mtime";
  };
}
