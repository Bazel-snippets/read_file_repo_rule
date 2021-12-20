# buildifier: disable=module-docstring
_template = """
package(default_visibility = ["//visibility:public"])

filegroup(
    name = "test_target",
    srcs = [],
)
"""

def _impl(repository_ctx):
    # print("in %s repository rule" % repository_ctx.name)
    workspace_real_path = repository_ctx.path(Label("@//:BUILD.bazel")).dirname
    print("workspace_real_path = %s" % workspace_real_path)
    test_file_path = workspace_real_path.get_child("test_file.txt")
    print("test_file_path = %s" % test_file_path)
    test_file_exists = test_file_path.exists
    print("test_file_exists = %s" % test_file_exists)

    end_of_line = "\r\n" if "windows" in repository_ctx.os.name else "\r"

    if test_file_exists:
        test_file_content = repository_ctx.read(test_file_path)
        test_file_lines = test_file_content.split(end_of_line)
    else:
        test_file_lines = []
    print("test file contains %s lines" % len(test_file_lines))
    repository_ctx.file("BUILD", executable = False, content = _template)


read_file_repo_rule = repository_rule(
    implementation = _impl,
    local = True,
    configure = True,
)
