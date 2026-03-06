package com.gms.repository;

import com.gms.dao.BatchDAO;
import com.gms.dao.ParticipantDAO;
import com.gms.model.Batch;
import com.gms.model.Participant;
import java.util.List;

public class GymRepository {

    private static final BatchDAO batchDAO = new BatchDAO();
    private static final ParticipantDAO participantDAO = new ParticipantDAO();

    // ===== BATCH METHODS =====
    public static void saveBatch(Batch b) { batchDAO.save(b); }
    public static void updateBatch(Batch b) { batchDAO.update(b); }
    public static void deleteBatch(int bid) { batchDAO.delete(bid); }
    public static Batch getBatch(int bid) { return batchDAO.get(bid); }
    public static List<Batch> getAllBatches() { return batchDAO.getAll(); }

    // ===== PARTICIPANT METHODS =====
    public static void saveParticipant(Participant p) { participantDAO.save(p); }
    public static void updateParticipant(Participant p) { participantDAO.update(p); }
    public static void deleteParticipant(int pid) { participantDAO.delete(pid); }
    public static Participant getParticipant(int pid) { return participantDAO.get(pid); }
    public static List<Participant> getAllParticipants() { return participantDAO.getAll(); }
    public static List<Participant> getParticipantsByBatch(int bid) { return participantDAO.getByBatch(bid); }
}
