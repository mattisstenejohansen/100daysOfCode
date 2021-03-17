use std::io;

fn main() {

    // define input variable as a String
    let mut input = String::new();

    println!("Convert Int to Binary: ");

    // use read_line() from std::io library
    match io::stdin().read_line(&mut input) {
        Ok(_) => {

            // trim the input and parse it as a u32 integer
            let trimmed = input.trim();
            match trimmed.parse::<u32>() {
                Ok(i) => {
                    // :b simply formats integer as a binary digit
                    println!("=> {} in binary is: {:b} ", i, i)
                },
                Err(..) => println!("this was not an integer: {}", trimmed)
            };
        },
        Err(e) => {
            println!("Error: {}", e);
        }
    }

}
