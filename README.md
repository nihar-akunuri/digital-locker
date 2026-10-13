# Digital Locker FSM in Verilog

A small digital-locker controller implemented as a finite-state machine (FSM) in Verilog. The design reads a serial sequence of one-bit inputs, waits for a submit signal, and briefly asserts an unlock output when the expected sequence has been entered.

## How it works

The `dlocker` module tracks entry progress through states and handles valid and invalid sequences.

- The expected input sequence through the entry states is **1, 1, 0, 1**.
- Assert `submit` after entering the sequence to request unlocking.
- A valid submission pulses `unlock` high for one clock cycle and clears the error counter.
- An invalid entry moves the FSM into an error state; submitting while in that state increments the error counter.
- After three counted errors, the FSM transitions to a locked state that remains locked until reset.

## Interface

| Signal | Direction | Description |
|---|---|---|
| `clk` | Input | State and output clock. |
| `rst` | Input | Resets the FSM to its idle state and clears the error counter. |
| `p_in` | Input | One-bit password entry. |
| `submit` | Input | Submits the current entry or clears an error state. |
| `unlock` | Output | One-cycle indication that a valid sequence was submitted. |

## Files

| File | Purpose |
|---|---|
| `dlocker.v` | Locker state machine, password-sequence tracking, error counter, and unlock pulse. |
| `tb_dlocker.v` | Applies reset, valid/invalid input sequences, and submit pulses. |

## Simulation

Compile `dlocker.v` and `tb_dlocker.v`, then run `tb_dlocker` as the simulation top. Inspect the waveform for state transitions, error counting, lockout, and the `unlock` pulse.

The included testbench supplies example sequences but does not contain an automated pass/fail scoreboard.

## Possible improvements

- Add a self-checking testbench for valid, invalid, and lockout scenarios.
- Define the desired behavior for reset during an entry and for submit while idle.
- Parameterize the password sequence and error threshold if the design is to be reused.

## Tools

- Verilog HDL
- Event-driven digital logic simulation
