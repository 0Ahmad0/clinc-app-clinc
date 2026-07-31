/// Which auth layer is on screen. They are one flow that cross-fades between
/// sub-views rather than separate routes (matches the design).
///
/// Two paths reach [otp]: signup (→ [pending] once verified) and forgot
/// password (→ [reset]).
enum AuthLayer { login, signup, forgot, otp, reset, pending }
