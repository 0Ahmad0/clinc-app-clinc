/// Which auth layer is on screen. The four are one flow that cross-fades between
/// sub-views rather than separate routes (matches the design).
enum AuthLayer { login, signup, forgot, pending }
