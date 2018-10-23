function [ R ] = qvec2R( qvec )
R = [1 - 2 * qvec(3)^2 - 2 * qvec(4)^2, 2 * qvec(2) * qvec(3) - 2 * qvec(1) * qvec(4),2 * qvec(4) * qvec(2) + 2 * qvec(1) * qvec(3);
     2 * qvec(2) * qvec(3) + 2 * qvec(1) * qvec(4), 1 - 2 * qvec(2)^2 - 2 * qvec(4)^2, 2 * qvec(3) * qvec(4) - 2 * qvec(1) * qvec(2);
     2 * qvec(4) * qvec(2) - 2 * qvec(1) * qvec(3), 2 * qvec(3) * qvec(4) + 2 * qvec(1) * qvec(2), 1 - 2 * qvec(2)^2 - 2 * qvec(3)^2];
end

