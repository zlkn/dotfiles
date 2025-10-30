// Rust — syntax sampler
use std::collections::HashMap;
use std::fmt::{self, Display};

#[derive(Clone, Debug, PartialEq, Eq, Hash)]
enum Color { Red = 1, Green = 2, Blue = 3 }

#[derive(Clone, Copy, Debug)]
struct Point<T> { x: T, y: T }

impl<T> Point<T> {
    fn new(x: T, y: T) -> Self { Self { x, y } }
}

fn distance(a: Point<f64>, b: Point<f64>) -> f64 {
    let (dx, dy) = (a.x - b.x, a.y - b.y);
    (dx*dx + dy*dy).sqrt()
}

trait Summable<T> { fn sum(self) -> T; }
impl<T, I> Summable<T> for I
where
    T: Default + std::ops::AddAssign,
    I: IntoIterator<Item = T>,
{
    fn sum(self) -> T {
        let mut s = T::default();
        for v in self { s += v; }
        s
    }
}

struct Label(&'static str);
impl Display for Label {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result { write!(f, "{}", self.0) }
}

fn main() -> Result<(), Box<dyn std::error::Error>> {
    let p = Point::new(0.0_f64, 1.0);
    let q = Point::new(2.0_f64, 3.0);
    let dist = distance(p, q);

    let squares: Vec<i32> = (1..=5).filter(|x| x % 2 == 1).map(|x| x*x).collect();
    let sum: i32 = squares.clone().sum();

    let mut map: HashMap<&str, f64> = HashMap::new();
    map.insert("sqrt", (49.0_f64).sqrt());

    let re = regex::Regex::new(r"(?i)^hello[\s-]*world$")?;
    let matched = re.is_match("Hello  - world");

    println!("{} → color={:?} dist={:.2} sum={} map={:?} matched={}",
             Label("preview"), Color::Red, dist, sum, map, matched);
    Ok(())
}

// Cargo.toml (for reference):
// [dependencies]
// regex = "1"

