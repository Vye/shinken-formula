import logging

log = logging.getLogger(__name__)


def get_module_names(modules, packs):
    '''
    Most modules are included by using the same name as the pack
    they were installed with. But sometimes the name is different.

    Cross reference each module with the packs list and replace
    the pack name with the module name when they are different.

    For example:
    The retention-memcache pack installs a module called MemcacheRetention.

    This function would replace retention-memcache in the modules
    list with MemcacheRetention.
    '''
    for pack, module in iter(packs.items()):
        if pack in modules:
            modules[modules.index(pack)] = packs[pack]
    return modules
