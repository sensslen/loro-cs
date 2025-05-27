fn main() {
    uniffi::generate_scaffolding("src/loro.udl").expect("Failed to generate scaffolding");
}
