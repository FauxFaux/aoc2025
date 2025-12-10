use itertools::Itertools;
use std::io::Write;

#[derive(Debug)]
struct Mach {
    buttons: Vec<Vec<usize>>,
    targets: Vec<usize>,
}

fn try_to_make(
    buttons: &[Vec<usize>],
    targets: &[usize],
    guess: usize,
    max_presses: &[usize],
) -> bool {
    let (here, rest) = buttons.split_first().unwrap();
    'eye: for i in (0..=guess.min(max_presses[0])).rev() {
        let mut targets = targets.to_vec();
        for p in here {
            match targets[*p].checked_sub(i) {
                Some(v) => targets[*p] = v,
                None => continue 'eye,
            }
        }
        if targets.iter().all(|v| *v == 0) {
            return true;
        }
        if rest.is_empty() {
            return false;
        }
        if try_to_make(rest, &targets, guess - i, &max_presses[1..]) {
            return true;
        }
    }
    false
}

fn try_guess(mach: &Mach, guess: usize, max_presses: &[usize]) -> bool {
    try_to_make(&mach.buttons, &mach.targets, guess, max_presses)
}

fn solve(mach: &Mach) -> usize {
    let min = *mach.targets.iter().max().unwrap();
    let max = mach.targets.iter().sum::<usize>();
    let max_presses = mach
        .buttons
        .iter()
        .map(|vals| {
            vals.iter()
                .map(|i| mach.targets[*i as usize])
                .min()
                .unwrap()
        })
        .collect_vec();

    println!("{:?} {:?} {:?}", min, max, max_presses);
    for guess in min..=max {
        print!(".");
        std::io::stdout().flush().unwrap();
        if try_guess(mach, guess, &max_presses) {
            return guess;
        }
    }
    panic!("no solution found");
}

fn main() {
    let data = include_str!("../d10.txt")
        .lines()
        .map(|l| {
            let (_, l) = l.split_once(']').unwrap();
            let (a, b) = l.trim().split_once('{').unwrap();
            let buttons = a
                .trim()
                .split_whitespace()
                .map(|v| {
                    v.trim_matches(')')
                        .trim_matches('(')
                        .split(',')
                        .map(|i| i.parse::<usize>().expect("parse"))
                        .collect_vec()
                })
                .collect_vec();
            let targets = b
                .trim()
                .split(',')
                .map(|v| {
                    v.trim_matches('}')
                        .trim_matches('{')
                        .parse::<usize>()
                        .expect("parse")
                })
                .collect_vec();

            Mach { buttons, targets }
        })
        .collect_vec();

    let mut run: usize = 0;
    solve(&data[1]);
    for (nr, mach) in data.iter().enumerate() {
        let res = solve(&mach);
        run += res;
        println!("Machine {}: {}", nr + 1, res);
    }

    println!("{run}");
}
