/// The three ways an appointment/report line can end. Iterating this drives the
/// stat cards, chart legend, stacked bars and per-report counts uniformly.
enum ReportOutcome { done, pending, cancelled }
