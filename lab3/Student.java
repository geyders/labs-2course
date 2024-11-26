
public class Student {

    private String id;
    private String name;
    private String lastName;
    private int age;
    private String group;

    //constructor
    public Student(String id, String name, String lastName, int age, String group) {
        this.id = id;
        this.name = name;
        this.lastName = lastName;
        this.age = age;
        this.group = group;
    }

    public String getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getLastName() {
        return lastName;
    }

    public int getAge() {
        return age;
    }

    public String getGroup() {
        return group;
    }

    @Override
    public String toString() {
        return "ID: " + id + ", Name: " + name + " " + lastName + ", Age: " + age + ", Group: " + group;
    }

    public static void main(String[] args) {
        StudentRegistery<Student> sr =new StudentRegistery<>();
        Student student = new Student("1", "Vladyslav", "Demchenko", 19, "241");
        sr.addStudent(student);
        Student student1 = new Student("2", "Dmytro", "Gridasov", 19, "243");
        sr.addStudent(student1);

    }
}


