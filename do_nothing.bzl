# buildifier: disable=module-docstring
def _do_nothing_rule_impl(ctx):
    pass

do_nothing_rule = rule(
    implementation = _do_nothing_rule_impl,
    attrs = {
        "target": attr.label(),
    }
)
