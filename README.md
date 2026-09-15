![version](https://img.shields.io/badge/version-21.1%2B-E23089)
![platform](https://img.shields.io/static/v1?label=platform&message=mac-intel%20|%20mac-arm%20|%20win-64&color=blue)

# HDI_4DWP_Thread_safety

A 4D **HDI** (How Do I) example benchmarking 4D Write Pro invoice generation across **preemptive** and **cooperative** worker processes, timing how many invoices each kind of process can build from the same template in a fixed time window — demonstrating that 4D Write Pro commands are safe (and fast) to run preemptively. Originally published by 4D as a binary `.4DB` example for **4D v16**; converted to the modern `.4DProject` architecture so it runs on current 4D releases.

## Origin

This project started as a binary `.4DB` example database originally distributed with 4D v16. It was converted to the modern project architecture (`.4DProject`) using 4D 21's built-in binary-to-project conversion tool, then modernised (syntax, localisation, dark mode) with the help of **GitHub Copilot**.

- **Blog post:** https://blog.4d.com/4d-write-pro-commands-in-preemptive-processes/
- **Original download:** n/a

## What it demonstrates

- **`CALL WORKER`** spinning up four named workers (`WorkerPreempN`) to build customer invoices from a 4D Write Pro bookmarked template, then repeating the same run with four cooperative workers (`WorkerCoopN`) — same data, same template, same code.
- The **`preemptive`** method attribute controlling execution: `launchInvoicesBuildPreemptive` is declared `"preemptive":"capable"`, `launchInvoicesBuildCooperative` is declared `"preemptive":"incapable"`, forcing 4D to run each on the process type its name implies — while both call the exact same `BuildInvoices` method to do the actual document assembly.
- **`WP GET BOOKMARKS`** / **`WP Bookmark range`** / **`WP Insert document body`**, the same template-driven invoice-assembly technique used to turn a single 4D Write Pro template into a stream of finished invoices (header, line items with sub-totals, filler lines, footer, page breaks).
- A three-step progress form (`HDI2`) that runs the preemptive batch for a configurable duration, then the cooperative batch for the same duration, then reports how many invoices each produced and computes a "preemptive was N times faster" ratio.
- A time-boxed **`KILL WORKER`** cutoff (`$timeToDie`) so each batch stops cleanly at the end of its allotted window regardless of how many invoices are in flight.

## Key commands

| Command | Used for |
|---|---|
| `CALL WORKER` | Dispatching invoice-build work to four preemptive or four cooperative named workers (`m_onTimer`) |
| `KILL WORKER` | Stopping a worker once the time budget for its batch has elapsed |
| `WP GET BOOKMARKS` / `WP Bookmark range` | Locating the named ranges (`Main_Header`, `Invoice_Line`, `Sub_Total`, `Total`, `Filler`, `Main_Footer`, ...) inside the invoice template (`BuildInvoices`) |
| `WP Insert document body` | Assembling each invoice by appending bookmarked ranges into the build document |
| `WP New` / `WP Text range` | Creating scratch documents and tracking the insertion point while an invoice is assembled |
| `WP Insert break` | Inserting page breaks between invoices and between overflow pages of the same invoice |

## How it works

`00_Start` opens the `HDI` splash form; `BtnDemo` opens the demo form `HDI2`, whose `On Load` seeds the demo tables and picks template #8 as the invoice layout. Clicking the start button resets the invoice-created table and arms a timer-driven state machine (`m_onTimer`) that steps through three phases:

1. **Preemptive phase** — for a configurable number of seconds, dispatch each customer's invoice build to one of four workers running `launchInvoicesBuildPreemptive`.
2. **Cooperative phase** — repeat the same work for the same duration using `launchInvoicesBuildCooperative` instead.
3. **Compare** — count how many `INVOICES_CREATED` records each phase produced and display the resulting speed-up.

Both launch methods forward to the same `BuildInvoices` method, which copies the template, walks each customer's invoice lines, and stitches together header/line/sub-total/footer bookmarked ranges via `WP Insert document body` — the only difference between the two runs is which kind of process the work happens to execute on.

## Points of interest

- **The comparison is fair by construction** — `launchInvoicesBuildPreemptive` and `launchInvoicesBuildCooperative` are two one-line wrappers whose only real difference is their `"preemptive"` method attribute; the actual 4D Write Pro work (`BuildInvoices`) is identical code running on both process kinds, so any throughput difference comes from the process model, not from different code paths.
- **`BuildInvoicesC.4dm` and `BuildInvoicesP.4dm`** are earlier drafts of `BuildInvoices` (with extra `LOG EVENT` tracing) that are no longer called from anywhere in the project — harmless leftovers from before the demo was simplified to reuse a single build routine for both phases; left in place rather than removed since they aren't the subject of this modernisation pass.
- **`Form1`** is a small standalone Write Pro viewer (pick a document via `Select document`, load it with `WP Import document`) that isn't wired into the splash/demo flow or any menu — another harmless leftover, kept as-is.
- Startup uses the modern splash pattern: window-reuse detection, `CALL WORKER`, non-blocking `DIALOG(...;*)`, and `Form.quit`/`BtnDemo` object method instead of interprocess variables and `QUIT 4D`.
- Full XLIFF localisation covers the menu and all three forms' text/labels via `:xliff:` references and `Localized string(...)`.
- Buttons are sized via `form-theme` CSS media queries (27px Liquid Glass / 23px classic) on both `.default` and `button.default` selectors, rather than a hardcoded `height`, so they stay correctly rounded under macOS Tahoe.
- No listboxes are used anywhere in this project, so the usual `truncateMode`/`resizingMode` listbox defaults don't apply here.

## Project structure

```
Project/Sources/
  Forms/HDI/               Splash/startup form (version gate) and its BtnDemo object method
  Forms/HDI2/               Main demo form: 3-step preemptive/cooperative benchmark and results
  Forms/Form1/               Standalone Write Pro document viewer (unused leftover)
  Methods/                 Startup, m_onTimer (benchmark state machine), BuildInvoices, launchInvoicesBuild*
  styleSheets*.css         Dark mode + Liquid Glass button sizing
```
