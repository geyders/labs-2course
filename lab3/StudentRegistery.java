import java.util.HashMap;
import java.util.Map;

 class StudentRegistery<T extends Student> {

    private Map<String, T> studentsMap;

    public StudentRegistery() {
        studentsMap = new HashMap<>();
    }


    public void addStudent(T student) {
        studentsMap.put(student.getId(), student);
        System.out.println("Added student: " + student);
    }

   
    public void removeStudent (T student) {
        studentsMap.remove(student.getId());
        System.out.println("Removed student: " + student);
    }

    public void searchStudent(T student) {
        System.out.println("Removed student: " + studentsMap.get(student.getId()));
        
    }
}

