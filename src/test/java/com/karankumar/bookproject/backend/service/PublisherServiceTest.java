package com.karankumar.bookproject.backend.service;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.List;
import java.util.logging.Level;

import javax.transaction.Transactional;
import javax.validation.constraints.NotBlank;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.TransactionSystemException;
import org.springframework.util.Assert;

import com.karankumar.bookproject.annotations.IntegrationTest;
import com.karankumar.bookproject.backend.entity.Author;
import com.karankumar.bookproject.backend.entity.Publisher;

import lombok.extern.java.Log;

@Log
@IntegrationTest
public class PublisherServiceTest {
    
    private final PublisherService publisherService;
    private final BookService bookService;
	
    @Autowired
    PublisherServiceTest(PublisherService publisherService, BookService bookService){
        this.publisherService = publisherService;
        this.bookService = bookService;
    }
	
    @BeforeEach
    void reset() {
        bookService.deleteAll();
        publisherService.deleteAll();	
    }
	
    @Test
    void testSaveAndConfirmDuplicateNameWithDifferentId() {
        // given
        Publisher publisher = new Publisher("Prateek");
        publisherService.save(publisher);

        Publisher publisherCopy = publisher;
        publisherService.save(publisherCopy);

        // when
        List<Publisher> savedPublishers = publisherService.findAll();

        // then
        assertEquals(2, savedPublishers.size());
    }
    
    @Transactional
    @Test
    void testSaveIntegrity() {
        // given
        Publisher publisher = new Publisher("Prateek");
        publisherService.save(publisher);
        
        // when
        Publisher existingPublisher = publisherService.findById(publisher.getId());
        publisherService.save(existingPublisher);

        // then
        assertEquals(2, publisherService.count());
    }
    
    @Test
    void savedAuthorCanBeFound() {
        // given
        Publisher publisher = new Publisher("First");

        // when
        publisherService.save(publisher);

        // then
        assertNotNull(publisherService.findById(publisher.getId()));
    }
    
    @Test
    void testPublisherNullName() {
        Publisher publisher = new Publisher(null);
        
        //when
        TransactionSystemException ex = assertThrows(TransactionSystemException.class,() -> {publisherService.save(publisher);});

        assertTrue(ex.getMostSpecificCause().getMessage().contains("must not be blank"));
    }
    
    @Test
    void testPublisherEmptyName() {
        Publisher publisher = new Publisher("");
        
        //when
        TransactionSystemException ex = assertThrows(TransactionSystemException.class,() -> {publisherService.save(publisher);});
        
    	assertTrue(ex.getMostSpecificCause().getMessage().contains("must not be blank"));
    }

}
