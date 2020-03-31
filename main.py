def define_env(env):
    """
    This is the hook for the functions (new form)
    """

    env.variables["hello"] = "hello"
    # use dot notation for adding
    env.variables["baz"] = "buz"
