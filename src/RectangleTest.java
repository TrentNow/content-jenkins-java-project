import org.junit.Test;
import static org.junit.Assert.assertEquals;

public class RectangleTest {
  Rectangle rectangle = new Rectangle(3, 4);

  @Test
  public void testGetArea() {
  
     assertEquals(rectangle.getArea(), 12);
}

  @Test
  public void testGetPerimeter() {

     assertEquals(rectangle.getPerimeter(), 14);
}

  @Test
  public void testGetLength() {

     assertEquals(rectangle.length, 3);
}

  @Test
  public void testGetWidth() {

     assertEquals(rectangle.width, 4);
}
}

