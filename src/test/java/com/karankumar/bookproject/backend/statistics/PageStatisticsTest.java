/*
    The book project lets a user keep track of different books they would like to read, are currently
    reading, have read or did not finish.
    Copyright (C) 2020  Karan Kumar

    This program is free software: you can redistribute it and/or modify it under the terms of the
    GNU General Public License as published by the Free Software Foundation, either version 3 of the
    License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful, but WITHOUT ANY
    WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
    PURPOSE.  See the GNU General Public License for more details.

    You should have received a copy of the GNU General Public License along with this program.
    If not, see <https://www.gnu.org/licenses/>.
 */

package com.karankumar.bookproject.backend.statistics;

import com.karankumar.bookproject.annotations.IntegrationTest;
import com.karankumar.bookproject.backend.entity.Author;
import com.karankumar.bookproject.backend.entity.Book;
import com.karankumar.bookproject.backend.entity.PredefinedShelf;
import com.karankumar.bookproject.backend.service.BookService;
import com.karankumar.bookproject.backend.service.PredefinedShelfService;
import com.karankumar.bookproject.backend.statistics.utils.StatisticTestUtils;
import com.karankumar.bookproject.backend.utils.PredefinedShelfUtils;
import static org.assertj.core.api.Assertions.assertThat;
import java.time.LocalDate;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;

@IntegrationTest
class PageStatisticsTest {
    private static BookService bookService;
    private static PredefinedShelfService predefinedShelfService;
    private static PageStatistics pageStatistics;

    @BeforeAll
    public static void setupBeforeAll(@Autowired BookService bookService,
                                      @Autowired PredefinedShelfService predefinedShelfService) {
        PageStatisticsTest.bookService = bookService;
        PageStatisticsTest.predefinedShelfService = predefinedShelfService;
    }

    @BeforeEach
    public void beforeEachSetup() {
        bookService.deleteAll();
        StatisticTestUtils.populateReadBooks(bookService, predefinedShelfService);
        PageStatisticsTest.pageStatistics = new PageStatistics(predefinedShelfService);
    }

    @Test
    void bookWithMostPagesExistsAndIsFound() {
        assertThat(pageStatistics.findBookWithMostPages().getTitle())
                .isEqualTo(StatisticTestUtils.getBookWithMostPages().getTitle());
    }

    @Test
    void onlyReadBooksCountTowardsMostPagesStatistics() {
        PredefinedShelf readingShelf = predefinedShelfService.findReadingShelf();

        Book readingBook = new Book("More pages than any read book",
                new Author("Joe", "Bloggs"), readingShelf);
        readingBook.setNumberOfPages(StatisticTestUtils.getBookWithMostPages()
                                                       .getNumberOfPages() + 50);
        bookService.save(readingBook);

        assertThat(pageStatistics.findBookWithMostPages().getTitle())
                .isEqualTo(StatisticTestUtils.getBookWithMostPages().getTitle());
    }

    @Test
    void testAveragePageLengthDivideByZero() {
        resetPageStatistics();
        assertThat(pageStatistics.calculateAveragePageLength()).isNull();
    }

    @Test
    void averagePageLengthExistsAndIsCorrect() {
        int averagePageLength =
                StatisticTestUtils.getTotalNumberOfPages() / StatisticTestUtils.getNumberOfBooks();
        assertThat(pageStatistics.calculateAveragePageLength()).isEqualTo(averagePageLength);
    }

    @Test
    void testAveragePageLengthWithFloatPointCalculation() {
        StatisticTestUtils.deleteBook(StatisticTestUtils.getBookWithHighestRating());
        pageStatistics = new PageStatistics(predefinedShelfService);
        Double averagePageLength = 267.0;
        assertThat(pageStatistics.calculateAveragePageLength()).isEqualTo(averagePageLength);
    }
    
    @Test
    void testNoBooksReadThisYear() {
        // given
        PredefinedShelf readShelf = predefinedShelfService.findReadShelf();
    	
        // when
        Book shortBook = new Book("Shortest book this year",
                new Author("Joe", "Bloggs"), readShelf);
        shortBook.setNumberOfPages(10);
        shortBook.setDateStartedReading(LocalDate.now().minusYears(3));
        shortBook.setDateFinishedReading(LocalDate.now().minusYears(2));
        bookService.save(shortBook);
        
        pageStatistics = new PageStatistics(predefinedShelfService);
        
        // then
        assertThat(pageStatistics.findBookWithMostPagesThisYear()).isEqualTo(null);
    }
    
    @Test
    void testLongestBookReadThisYear() {
        // given
        PredefinedShelf readShelf = predefinedShelfService.findReadShelf();

        // when
        Book longBook = new Book("Longest book this year",
                new Author("Joe", "Bloggs"), readShelf);
        longBook.setNumberOfPages(100);
        longBook.setDateStartedReading(LocalDate.now().minusDays(3));
        longBook.setDateFinishedReading(LocalDate.now().minusDays(2));
        bookService.save(longBook);
        
        Book shortBook = new Book("Shortest book this year",
                new Author("Joe", "Bloggs"), readShelf);
        shortBook.setNumberOfPages(10);
        shortBook.setDateStartedReading(LocalDate.now().minusDays(3));
        shortBook.setDateFinishedReading(LocalDate.now().minusDays(2));
        bookService.save(shortBook);
        
        pageStatistics = new PageStatistics(predefinedShelfService);
        
        // then
        assertThat(pageStatistics.findBookWithMostPagesThisYear().getTitle())
                                 .isEqualTo(longBook.getTitle());
    }
    
    @Test
    void testShortestBookReadThisYear() {
        // given
        PredefinedShelf readShelf = predefinedShelfService.findReadShelf();

        // when
        Book longBook = new Book("Longest book this year",
                new Author("Joe", "Bloggs"), readShelf);
        longBook.setNumberOfPages(100);
        longBook.setDateStartedReading(LocalDate.now().minusDays(3));
        longBook.setDateFinishedReading(LocalDate.now().minusDays(2));
        bookService.save(longBook);
        
        Book shortBook = new Book("Shortest book this year",
                new Author("Joe", "Bloggs"), readShelf);
        shortBook.setNumberOfPages(10);
        shortBook.setDateStartedReading(LocalDate.now().minusDays(3));
        shortBook.setDateFinishedReading(LocalDate.now().minusDays(2));
        bookService.save(shortBook);
        
        pageStatistics = new PageStatistics(predefinedShelfService);
        
        // then
        assertThat(pageStatistics.findBookWithLeastPagesThisYear().getTitle())
                                 .isEqualTo(shortBook.getTitle());
   }
    
   @Test
   void testAverageBookLengthReadThisYear() {
        // given
        PredefinedShelf readShelf = predefinedShelfService.findReadShelf();

        // when
        Book longBook = new Book("Longest book this year",
                new Author("Joe", "Bloggs"), readShelf);
        longBook.setNumberOfPages(100);
        longBook.setDateStartedReading(LocalDate.now().minusDays(3));
        longBook.setDateFinishedReading(LocalDate.now().minusDays(2));
        bookService.save(longBook);
        
        Book shortBook = new Book("Shortest book this year",
                new Author("Joe", "Bloggs"), readShelf);
        shortBook.setNumberOfPages(10);
        shortBook.setDateStartedReading(LocalDate.now().minusDays(3));
        shortBook.setDateFinishedReading(LocalDate.now().minusDays(2));
        bookService.save(shortBook);
        
        pageStatistics = new PageStatistics(predefinedShelfService);
        
        // then
        Double expectedAverage;
        expectedAverage = (double) ((longBook.getNumberOfPages() + 
                                     shortBook.getNumberOfPages()) / 2);
        assertThat(pageStatistics.calculateAveragePageLengthThisYear())
                                 .isEqualTo(expectedAverage);
   }

    private void resetPageStatistics() {
        bookService.deleteAll();
        pageStatistics = new PageStatistics(predefinedShelfService);
    }
}
