
import java.util.ArrayList;
import java.util.List;

abstract class Animal {

    public abstract void makeSound();
}

class Dog extends Animal {

    @Override
    public void makeSound() {
        System.out.println("Dog: Woof Woof");
    }
}

class Labrador extends Dog {

    @Override
    public void makeSound() {
        System.out.println("Labrador: Woof Woof (I'm a Labrador!)");
    }
}

class Cat extends Animal {

    @Override
    public void makeSound() {
        System.out.println("Cat: Meow");
    }
}

class AnimalShelter {

    private List<Dog> dogs = new ArrayList<>();

    private List<Animal> otherAnimals = new ArrayList<>();

    public void addAnimals(List<? extends Dog> dogList, List<? extends Animal> otherAnimalList) {
        dogs.addAll(dogList);
        otherAnimals.addAll(otherAnimalList);
    }

    public void printAnimalSounds() {
        System.out.println("Sounds of Dogs:");
        for (Dog dog : dogs) {
            dog.makeSound();
        }

        System.out.println("\nSounds of Other Animals:");
        for (Animal animal : otherAnimals) {
            animal.makeSound();
        }
    }
}

public class MainAnimal {

    public static void main(String[] args) {

        Dog dog = new Dog();
        Labrador labrador = new Labrador();
        Cat cat = new Cat();

        List<Dog> dogList = new ArrayList<>();
        dogList.add(dog);
        dogList.add(labrador);

        List<Animal> otherAnimalsList = new ArrayList<>();
        otherAnimalsList.add(cat);

        AnimalShelter shelter = new AnimalShelter();

        shelter.addAnimals(dogList, otherAnimalsList);

        shelter.printAnimalSounds();
    }
}
